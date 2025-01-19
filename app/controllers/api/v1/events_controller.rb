module Api
  module V1
    class EventsController < ApplicationController

      #api_v1_events GET    /api/v1/events(.:format)
      def index

        @events=Event.all

        render json: @events

      end

      #create new
      #POST   /api/v1/events(.:format)
      def create

        event=Event.new(title: "Event1", 
        description: "event description", 
        start_time: DateTime.now, 
        end_time: DateTime.now+1.day)

        if event.save
          render json: {message: 'Event created successfully', data: event}
        else
          render json: {message: 'Failed to create', data: event.errors}
        end

      end

      #show 
      #GET    /api/v1/events/:id(.:format)
      def show

      end

      #update
      #PATCH  /api/v1/events/:id(.:format)
      #PUT    /api/v1/events/:id(.:format)
      def update

      end

      #delete
      #DELETE /api/v1/events/:id(.:format)
      def delete
        
      end
    end
  end
end