module Api

  module V1
    class UsersController < ApiController

      def sync
        render json: current_resource_owner.attributes, status: 200
      end

      def test
        render json: {
          testing: 'Hello',
          user: current_resource_owner.attributes
        }
      end

    end
  end

end
