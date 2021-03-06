#Collection of methods used for Sales Engine repository creation
module SalesEngineCreate

  def create_item_repo(files)
    if files.include?(:items)
      ItemRepository.new(files[:items], self)
    end
  end

  def create_merchants_repo(files)
    if files.include?(:merchants)
      MerchantRepository.new(files[:merchants], self)
    end
  end

  def create_invoices_repo(files)
    if files.include?(:invoices)
      InvoiceRepository.new(files[:invoices], self)
    end
  end

  def create_invoice_item_repo(files)
    if files.include?(:invoice_items)
      InvoiceItemRepository.new(files[:invoice_items], self)
    end
  end

  def create_transaction_repo(files)
    if files.include?(:transactions)
      TransactionRepository.new(files[:transactions], self)
    end
  end

  def create_customer_repo(files)
    if files.include?(:customers)
      CustomerRepository.new(files[:customers], self)
    end
  end



end