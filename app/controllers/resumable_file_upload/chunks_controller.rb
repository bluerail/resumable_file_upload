require_dependency 'resumable_file_upload/application_controller'

module ResumableFileUpload
  class ChunksController < ApplicationController
    layout nil

    before_action :ensure_upload_dir, only: :create

    def show
      if File.exist?(chunk_file)
        render status: 200, body: nil
      else
        render status: 404, body: nil
      end
    end

    def create
      empty_upload_folder! if first_chunk?

      process_new_chunk

      complete_chunks if upload_complete?

      render body: nil
    end

    private

    def upload_params
      params.permit(%i[file resumableChunkNumber resumableTotalChunks resumableChunkSize resumableTotalSize
                       resumableIdentifier resumableFilename resumableRelativePath resumableCurrentChunkSize
                       resumableType])
    end

    def upload_dir
      Rails.root.join('tmp', 'resumable_file_upload', upload_params[:resumableIdentifier])
    end

    def chunk_file(chunk_index = nil)
      upload_dir.join(
        %(#{upload_params[:resumableFilename]}.part#{chunk_index || upload_params[:resumableChunkNumber]})
      )
    end

    def target_file
      upload_dir.join(%(#{upload_params[:resumableFilename]}))
    end

    def process_new_chunk
      FileUtils.mv upload_params[:file].tempfile, chunk_file
    end

    def complete_chunks
      File.open(target_file, 'wb') do |target|
        for chunk_index in 1..params[:resumableChunkNumber].to_i
          target.write File.open(chunk_file(chunk_index), 'rb').read

          FileUtils.rm chunk_file(chunk_index), force: true
        end
      end
    end

    def ensure_upload_dir
      return if File.directory?(upload_dir)

      FileUtils.mkdir_p upload_dir, mode: 0o700
    end

    def empty_upload_folder!
      FileUtils.rm_rf Dir.glob("#{upload_dir}/*")
    end

    def first_chunk?
      upload_params[:resumableChunkNumber].to_i == 1
    end

    def upload_complete?
      (current_size + new_chunk_size) >= expected_size
    end

    def current_size
      upload_params[:resumableChunkNumber].to_i * upload_params[:resumableChunkSize].to_i
    end

    def new_chunk_size
      upload_params[:resumableCurrentChunkSize].to_i
    end

    def expected_size
      upload_params[:resumableTotalSize].to_i
    end
  end
end
