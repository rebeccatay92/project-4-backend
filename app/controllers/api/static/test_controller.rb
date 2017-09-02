module Api

  module Static
    class TestController < ApiController

      def test
        render json: {
          testing: 'Hello from test'
        }
      end

    end
  end

end
