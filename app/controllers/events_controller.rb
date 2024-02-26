class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    before_action :authenticate_request, except: [:index]

    def index
        events = Event.order(created_at: :desc).page(params[:page]).per(12)
        render json: {
            events: EventsBlueprint.render_at_hash(events, view: :short), total_pages: event.total_pages, current_page: events.current_page
    }
    end

    def show
        render json: @event, status: :ok
    end

    def create
        event = @current_user.created_events

        if event.save
            render json: event, status: :created_events

        end
    end
end
