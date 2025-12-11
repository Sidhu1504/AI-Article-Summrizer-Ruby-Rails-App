class SummarizeArticleJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(article_id)
    article = Article.find(article_id)
    # In a real application, you would make an API call to an AI service
    # to summarize the article's content based on its URL.
    # For this example, we'll just simulate the summarization process.
    article.update(summary: "This is a summarized version of the article.")
  end
end
