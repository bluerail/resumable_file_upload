module ResumableFileUpload
  module ApplicationHelper
    def resumable_file_upload_tag(input_name, input_options = {})
      content_tag(:div, class: 'resumable-file-upload') do
        safe_join([
                    content_tag(:span, 'Browse', class: :browse_button),
                    content_tag(:span, 'Drop', class: :drop_target),
                    content_tag(:span, 'Progress', class: :progress_bar),
                    content_tag(:span, 'Info', class: :progress_info),
                    content_tag(:span, 'Pause', class: :pause_button),
                    content_tag(:span, 'Resume', class: :resume_button),
                    content_tag(:span, 'Cancel', class: :cancel_button),
                    tag(:input, input_options.merge(name: input_name))
                  ])
      end
    end
  end
end
