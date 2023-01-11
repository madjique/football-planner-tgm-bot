FROM ruby:2.7.0

# Install necessary system packages
RUN apt-get update -qq && apt-get install -y build-essential

# Set working directory
WORKDIR /bot

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Run the command to start the server
CMD ["ruby", "runner.rb"]
