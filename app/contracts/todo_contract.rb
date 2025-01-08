class TodoContract < Dry::Validation::Contract
  params do
    required(:title).filled(:string)
    required(:status).filled(:string, included_in?: %w[pending completed])
    required(:priority).filled(:string, included_in?: %w[low medium high])
  end
end
