module ActiveMerchant
  module Billing
    module PaymentechOrbital
      module Request
        class Void < PaymentechOrbital::Request::Base
          attr_reader :tx_ref_num, :tx_ref_idx, :money

          def initialize(tx_ref_num, options={}, money=nil, tx_ref_idx=1)
            @tx_ref_num = tx_ref_num
            @tx_ref_idx = tx_ref_idx
            @money = money
            super(options)
          end

          def request_type; "Reversal"; end

          def to_s
            "Void: #{tx_ref_num}"
          end

          def industry_type; nil; end

          private
          def request_body(xml)
            add_transaction_info(xml)
            xml.tag! "AdjustedAmt", money if money
            add_meta_info(xml)
          end

          def add_transaction_info(xml)
            xml.tag! "TxRefNum", tx_ref_num
            xml.tag! "TxRefIdx", tx_ref_idx
          end

          def add_meta_info(xml)
            xml.tag! "OrderID", order_id
            xml.tag! "BIN", bin
            xml.tag! "MerchantID", merchant_id
            xml.tag! "TerminalID", terminal_id
          end
        end
      end
    end
  end
end