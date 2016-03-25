# We will build the container from the standard garuda image.
# this image is itself based on the standard python images, and
# contains all the needed garuda dependencies already installed.
FROM monolithe/garuda:latest

# That's me! hello there!
MAINTAINER Antoine Mercadal <antoine@nuagenetworks.net>

# We will need to install the package containing our
# monolithe sdk.
COPY tdldk-1.0.tar.gz /eggs/tdldk-1.0.tar.gz

# We also add our server file.
COPY server /
COPY listlogic.py /

# Then we install the tdldk, and we clean everything up
RUN pip install /eggs/tdldk-1.0.tar.gz && rm -rf /eggs

# We expose the port 3000
EXPOSE 3000

# Then we tell that this container will run our server
CMD /server
