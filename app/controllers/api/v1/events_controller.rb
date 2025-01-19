module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[ show update destroy ]

      #api_v1_events GET    /api/v1/events(.:format)
      def index
        @events = Event.all

        render json: @events
      end

      #create new
      #POST   /api/v1/events(.:format)
      def create
        event = Event.new(event_params)

        if event.save
          render json: { message: "Event created successfully", data: event }
        else
          render json: { message: "Failed to create", data: event.errors }, status: :unprocessable_entity
        end
      end

      #show
      #GET    /api/v1/events/:id(.:format)
      def show
        if @event.nil?
          render json: { message: "No Event found" }, status: :unprocessable_entity
        else
          render json: @event
        end
      end

      #update
      #PATCH  /api/v1/events/:id(.:format)
      #PUT    /api/v1/events/:id(.:format)
      def update
        if @event.nil?
          render json: { message: "No event found" }, status: :unprocessable_entity
          return
        end

        if @event.update(event_params)
          render json: { message: "Event updated successfully", data: @event }
        else
          render json: { message: "Unable to update event", data: @event.errors }, status: :unprocessable_entity
        end
      end

      #delete
      #DELETE /api/v1/events/:id(.:format)
      def destroy
        if @event.nil?
          render json: { message: "No event found" }, status: :unprocessable_entity
          return
        end

        if @event.delete
          render json: { message: "Event deleted" }
        else
          render json: { message: "Unable to delete event", data: @event.errors, status: :unprocessable_entity }
        end
      end

      private

      def set_event
        @event = Event.find_by(id: params[:id])
      end

      def event_params
        params.permit(:title, :description, :start_time, :end_time, :location)
      end
    end
  end
end
