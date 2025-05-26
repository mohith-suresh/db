# Use the official PostgreSQL image as a base image
FROM postgres:15

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    postgresql-server-dev-15 \
    git

# Clone the pgvector repository
RUN cd /tmp && \
    git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install

# Clean up
RUN apt-get remove -y build-essential git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/pgvector

# Set the default command to run when starting the container
CMD ["postgres"]
