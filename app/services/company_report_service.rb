class CompanyReportService
  def self.tweets_count_by_company
    sql = <<-SQL
      SELECT companies.name, COUNT(tweets.id) AS tweets_count
      FROM companies
      INNER JOIN users ON users.company_id = companies.id
      INNER JOIN tweets ON tweets.user_id = users.id
      GROUP BY companies.name
      ORDER BY tweets_count DESC
    SQL
    ActiveRecord::Base.connection.exec_query(sql)
  end
end