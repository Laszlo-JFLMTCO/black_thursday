require_relative 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader     :test_transaction_repo,
                  :transactions_list

  def setup
    @test_transaction_repo = TransactionRepository.new("./data/transactions_fixture.csv", "parent")
    @transactions_list = test_transaction_repo.transactions_list
  end
  
  def test_initialize_invoiceitem_repository
    assert test_transaction_repo
  end

  def test_creates_transaction_list
    refute_empty transactions_list
  end

  def test_transaction_list_stores_transactions
    assert_equal Transaction, transactions_list.first.class
  end

  def test_all_method_returns_all_transactions
    result = test_transaction_repo.all
    assert_equal Transaction, result.first.class
    assert_equal 10, result.length
  end

  def test_finds_transaction_by_id
    result = test_transaction_repo.find_by_id(9)
    assert_equal 4463525332822998, result.credit_card_number
  end

  def test_finds_transaction_by_id_not_in_repository
    result = test_transaction_repo.find_by_id(999)
    assert_nil result
  end  

  def test_finds_all_transactions_by_invoice_id
    result = test_transaction_repo.find_all_by_invoice_id(2)
    assert_equal Transaction, result.first.class
    assert_equal 2, result.count
    assert_equal 6, result.first.id
    assert_equal 4839506591130477, result.last.credit_card_number
  end

  def test_finds_all_transactions_by_invoice_id_not_in_repository
    result = test_transaction_repo.find_all_by_invoice_id(999)
    assert_empty result
  end  

  def test_finds_all_transactions_with_given_credit_card_number
    result = test_transaction_repo.find_all_by_credit_card_number(4068631943231473)
    assert_equal Transaction, result.first.class
    assert_equal 2, result.count
    assert_equal 1, result.first.id
    assert_equal 9, result.last.invoice_id
  end

  def test_finds_all_transactions_with_given_credit_card_number_not_in_repository
    result = test_transaction_repo.find_all_by_credit_card_number(999)
    assert_empty result
  end

  def test_finds_all_transactions_with_given_result
    result = test_transaction_repo.find_all_by_result("failed")
    assert_equal Transaction, result.first.class
    assert_equal 2, result.count
    assert_equal 3, result.first.id
    assert_equal 4463525332822998, result.last.credit_card_number
  end

  def test_finds_all_transactions_with_given_result_not_in_repository
    result = test_transaction_repo.find_all_by_result("notinrepository")
    assert_empty result
  end

  def test_transaction_calls_parent_for_invoice
    parent = MiniTest::Mock.new
    transaction_repo = TransactionRepository.new("./data/transactions_one.csv", parent)
    parent.expect(:find_invoice, nil, [26])
    transaction_repo.find_invoice(26)
    parent.verify
  end


end