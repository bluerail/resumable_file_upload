ResumableFileUpload::Engine.routes.draw do
  resource :chunk, only: %i[create show]
end
