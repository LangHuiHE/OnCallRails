# Use the official Ruby image
FROM ruby:3.2.2

# Set the working directory
WORKDIR /app

# Install a specific version of Bundler
RUN gem install bundler -v '2.4.18'

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install dependencies using the specified version of Bundler
RUN bundle _2.4.18_ install

# Copy the rest of the application code
COPY . .

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
