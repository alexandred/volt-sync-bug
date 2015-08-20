# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    model :store

    def index
      online_or_create_participant
    end

    def all_participants
      participants.all.then do |a|
        a
      end
    end

    def index_ready
      unload_participant_func = lambda { unload_participant }
      `$(window).on('beforeunload', function(){ unload_participant_func();});`
    end

    def before_index_remove
      print "test"
      unload_participant
    end

    def unload_participant
      Volt.current_user.participants.first.then do |a|
        a.presence = "offline"
      end
    end

    def online_or_create_participant

      Volt.current_user.participants.first.then do |a|
        if !a
          Volt.current_user.participants.create(presence: "online")
        else
          a.presence = "online"
        end
      end
    end

    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
