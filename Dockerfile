FROM python:3.12-trixie

# Set Zurich timezone
ENV TZ="Europe/Zurich"

# Headless Workaround
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y neovim firefox-esr wget xvfb x11vnc

RUN GECKO_VERSION=v0.37.1 && \
    wget -q "https://github.com/mozilla/geckodriver/releases/download/${GECKO_VERSION}/geckodriver-${GECKO_VERSION}-linux64.tar.gz" -O /tmp/geckodriver.tar.gz && \
    tar -xzf /tmp/geckodriver.tar.gz -C /usr/local/bin/ && \
    rm /tmp/geckodriver.tar.gz

# Copy source files & install dependencies
COPY src/requirements.txt .
RUN python3 -m pip install -r requirements.txt

COPY src .
COPY start_command .
RUN chmod +x start_command

CMD ["bash", "start_command"]

# CMD ["tail", "-f", "/dev/null"]
