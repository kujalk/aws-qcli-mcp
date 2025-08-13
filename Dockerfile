FROM python:3.11-slim

# Install basic tools
RUN apt-get update && apt-get install -y \
    curl \
    graphviz \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install uv (to run MCP servers)
RUN pip install --no-cache-dir uv

# Install Amazon Q CLI
RUN curl --proto '=https' --tlsv1.2 -sSf "https://desktop-release.q.us-east-1.amazonaws.com/latest/q-x86_64-linux-musl.zip" -o "q.zip"
RUN  unzip q.zip && cd q && chmod +x install.sh && ./install.sh --force --no-confirm

# Install MCP servers
RUN uv tool install awslabs.aws-diagram-mcp-server
RUN uv tool install awslabs.aws-documentation-mcp-server

# Create config directory for MCP servers
RUN mkdir -p /root/.aws/amazonq

# Copy MCP server config
COPY mcp.json /root/.aws/amazonq/mcp.json

# Set default working directory
WORKDIR /workspace

# Start shell when running container
ENTRYPOINT ["/bin/bash"]
