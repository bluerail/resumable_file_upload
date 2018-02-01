Rails.application.routes.draw do
  mount ResumableFileUpload::Engine => "/resumable_file_upload"
end
