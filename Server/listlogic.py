from garuda.core.models import GAPluginManifest, GARequest
from garuda.core.plugins import GALogicPlugin


class ListsBusinessLogic(GALogicPlugin):
    """
        Business Logic Plugin for List Creation
    """

    @classmethod
    def manifest(cls):
        """
            Returns a GAPluginManifest that contains information about the plugin.
            Aslo contains the subscriptions information,
        """
        return GAPluginManifest(name='list business logic',
                                version=1.0,
                                identifier="tdl.server.businesslogic",
                                subscriptions={
                                    # The delegates methods of this plugin will be called on creation of
                                    # entity of type list.
                                    "list": [GARequest.ACTION_CREATE]
                                })

    def will_perform_create(self, context):
        """
        """
        # the context contains all needed
        # information about the client request, the objects
        # that needs to be worked on, etc.
        # Here we just need to get the actual list that is being
        # created.
        tdlist = context.object

        # If desctiption attribute is not set, then we modify the value to
        # something. This is just for the sake of example :)
        if not tdlist.description or not len(tdlist.description):
            tdlist.description = "Why U no put description?"

        # And we always return the context.
        # we do this, as garuda will lauch business logic
        # in paralel, and will merge all the contexts together when
        # everybody is done.
        return context
