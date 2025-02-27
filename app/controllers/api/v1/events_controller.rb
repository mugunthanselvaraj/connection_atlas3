module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!, only: %i[create update destroy]
      before_action :authorize_admin, only: %i[create update destroy]
      before_action :set_event, only: %i[ show update destroy add_images remove_image ]

      #api_v1_events GET    /api/v1/events(.:format)
      def index
        @events = Event.all

        render json: @events
      end

      def past
        @events = Event.past
        render json: @events
      end

      def active
        @events = Event.active
        render json: @events
      end

      def upcoming
        @events = Event.upcoming
        render json: @events
      end

      def active_upcoming
        @active_events = Event.active
        @upcoming_events = Event.upcoming
        render json: { active: @active_events, upcoming: @upcoming_events }
      end

      #create new
      #POST   /api/v1/events(.:format)
      def create
        @event = current_user.events.build(event_params)

        if @event.save
          render json: { message: "Event created successfully", data: @event }
        else
          render json: { message: "Failed to create", data: @event.errors }, status: :unprocessable_entity
        end
      end

      #show
      #GET    /api/v1/events/:id(.:format)
      def show
        if @event
          render json: @event
        else
          render json: { message: "No Event found" }, status: :unprocessable_entity
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

      # Upload multiple images to an event
      def add_images
        if params[:images].present?
          params[:images].each do |image|
            @event.event_images.create(image: image)
          end
          render json: { message: "Images uploaded successfully", data: @event.event_images }, status: :ok
        else
          render json: { message: "No images provided" }, status: :unprocessable_entity
        end
      end

      # Delete a specific image from an event
      def remove_image
        event_image = @event.event_images.find_by(id: params[:image_id])

        if event_image
          event_image.destroy
          render json: { message: "Image deleted successfully" }, status: :ok
        else
          render json: { message: "Image not found" }, status: :not_found
        end
      end

      private

      def set_event
        @event = Event.find_by(id: params[:id])
      end

      def event_params
        params.require(:event).permit(
          :title,
          :description,
          :start_time,
          :end_time,
          :maximum_participants,
          event_location_attributes: [:laltitude, :longitude, :name],
          event_images_attributes: [:id, :image, :_destroy],
        )
      end

      def authorize_admin
        unless current_user.email == ENV["ADMIN_EMAIL"]
          render json: { message: "Forbidden action" }, status: :unauthorized
        end
      end
    end
  end
end
