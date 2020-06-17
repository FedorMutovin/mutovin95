# frozen_string_literal: true

module Company
  attr_reader :company_name
  def add_company_name(name)
    self.company_name = name
  end

  def show_company_name
    company_name
  end

  protected

  attr_writer :company_name
end
