FROM continuumio/miniconda3:latest

# Set Zurich timezone
ENV TZ="Europe/Zurich"

# Headless Workaround
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y neovim firefox-esr

# Copy source files & install dependencies
COPY src/requirements.txt .
RUN python3 -m pip install -r requirements.txt

COPY src .
COPY enroll.sh .
COPY start-command.sh .

CMD ["bash", "-c", "python3 asvz_bot.py"]

# CMD ["tail", "-f", "/dev/null"]
