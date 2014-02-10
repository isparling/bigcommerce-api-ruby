require 'spec_helper'

describe Bigcommerce::Api do
  include_context "mock api"

  describe "orders_by_date" do
    it "should accept a valid Date object" do
      date = DateTime.now
      parsed_date = described_class.new.to_rfc2822(date)
      api.connection.should_receive(:get).once.with("/orders",
                                                    {:min_date_created => parsed_date})
      api.orders_by_date(date)
    end

    it "should parse a valid date string" do
      date = described_class.new.to_rfc2822(DateTime.parse('2012-1-1'))
      api.connection.should_receive(:get).once.with("/orders",
                                                    {:min_date_created => date})
      api.orders_by_date('2012-1-1')
    end
  end

  describe "#create-orders-shipments" do
    it "should accept an order id parameter" do
      api.connection.should_receive(:post).once.with("/orders/123/shipments", {})
      api.create_orders_shipments(123)
    end

    it "should accept an order id parameter and an options hash" do
      options = Hash[*('A'..'Z').to_a.flatten]
      api.connection.should_receive(:post).once.with("/orders/123/shipments", options)
      api.create_orders_shipments(123, options)
    end
  end

  describe "#get-options-value" do
    it "should accept an option id parameter" do
      api.connection.should_receive(:get).once.with("/options/123/values", {})
      api.options_value(123)
    end

    it "should accept an option id parameter and an options hash" do
      options = Hash[*('A'..'Z').to_a.flatten]
      api.connection.should_receive(:get).once.with("/options/123/values", options)
      api.options_value(123, options)
    end
  end
  
  describe "#create-product-customfields" do
    it "should accept a product-id parameter" do
      api.connection.should_receive(:post).once.with("/products/123/customfields", {})
      api.create_products_customfield(123)
    end
    it "should accept an option id parameter and an options hash" do
      options = Hash[*('A'..'Z').to_a.flatten]
      api.connection.should_receive(:post).once.with("/products/123/customfields", options)
      api.create_products_customfield(123, options)
    end
  end
  
  describe "#destroy-products!" do
    it "should accept no parameters" do
      api.connection.should_receive(:delete).once
      api.destroy_products!
    end
  end
  
  describe "#create-products-sku" do
    it "should accept an option id parameter" do
      api.connection.should_receive(:post).once.with("/products/123/skus", {})
      api.create_products_sku(123)
    end

    it "should accept an option id parameter and an options hash" do
      options = Hash[*('A'..'Z').to_a.flatten]
      api.connection.should_receive(:post).once.with("/products/123/skus", options)
      api.create_products_sku(123, options)
    end
  end
end
