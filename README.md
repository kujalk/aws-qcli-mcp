# Amazon Q CLI with AWS Diagram & Documentation MCP Servers (Dockerized)

This repository provides a Dockerized setup for running **Amazon Q CLI** along with:
- **AWS Diagram MCP Server** (`awslabs.aws-diagram-mcp-server`)
- **AWS Documentation MCP Server** (`awslabs.aws-documentation-mcp-server`)

You can use this container to chat with Amazon Q and generate AWS architecture diagrams directly from inside Docker.

---

## 📦 Build the Docker Image

Clone this repository and build the Docker image:

```bash
docker build -t amazonq-mcp .
```

---

## ▶️ Run the Container

Run the container interactively, mounting a host folder for generated diagrams:

```bash
docker run -it --rm     -v "$(pwd)/diagram:/workspace/q/generated-diagrams"     -v "$HOME/.aws:/root/.aws"     amazonq-mcp
```

**Explanation:**
- `$(pwd)/diagram` → Host directory to store generated diagrams.
- `/workspace/generated-diagrams/` → Container path where Amazon Q saves diagrams.
- `$HOME/.aws:/root/.aws` → Mount your AWS credentials/config so Amazon Q CLI can authenticate.

---

## 🔑 Login to Amazon Q

Inside the container, run:

```bash
q login
```

Follow the prompts:
1. A browser window will open for AWS SSO login.
2. Select your AWS account and SSO profile.
3. **Select the desired build ID** when prompted.

---

## 💬 Start Chatting with Amazon Q

Once logged in, start a chat session:

```bash
q chat
```

Example prompt:

```
Generate an AWS architecture diagram for a VPC with two subnets, EC2 instance, and RDS.
```

The diagram will be generated and saved in:
```
./diagram
```
(on your host machine).

---

## 📂 Repository Structure

```
.
├── Dockerfile          # Container build instructions
├── mcp.json            # MCP server configuration
├── README.md           # This documentation
└── diagram/            # Generated diagrams (created automatically)
```

---

## 🛠 Notes
- Requires Docker installed on your host machine.
- Graphviz is pre-installed in the container for diagram rendering.

---

