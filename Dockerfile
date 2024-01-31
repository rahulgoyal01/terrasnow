# Use an official Terraform image as the base image
FROM cmdlabs/terraform-utils:11.0.3

# Set environment variables
ENV NO_SSL=${NO_SSL}
ENV SNOWFLAKE_AUTHENTICATOR=JWT
ENV SNOWFLAKE_PROFILE="/work/profiles/config"
ENV SNOWFLAKE_PRIVATE_KEY_PATH="/work/init/snowflake_key"

# Set the working directory
WORKDIR /work

# Copy the current directory contents into the container at /work
COPY . /work

# Create the required volumes
# VOLUME /root/.snowflake/config
# VOLUME /root/.ssh/

# (Optional) Expose any necessary ports
# EXPOSE ...

# (Optional) Define any default command to run when the container starts
CMD sh -c '-chdir="./stacks/dev1" init'