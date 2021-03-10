class Transfer

      attr_reader :sender, :receiver, :amount
      attr_accessor :status

  def initialize (sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @amount = amount
      @status = "pending"
  end

  def valid?
      sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && (sender.balance > self.amount)  && (self.status == "pending")
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    else
     transfer_denied
    end
  end

  def reverse_transfer
    if valid? && (receiver.balance > self.amount)  && (self.status == "complete")
      receiver.balance -= self.amount
      sender.balance += self.amount
      self.status = "reversed"
    else
    transfer_denied
    end
  end

  def transfer_denied
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

end
