<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/nicolodiamante/zchat/assets/48920263/2eae1d23-a5b0-484c-ba57-ea30a821545d" draggable="false" ondragstart="return false;" alt="Zchat" title="Zchat" />
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/42de772d-6457-47bd-b5b7-fc5b624e56ef" draggable="false" ondragstart="return false; "alt="Zchat" title="Zchat" />
  </picture>
</p>

Boost your productivity and enhance your terminal experience using Zchat (zch). This command-line productivity tool is powered by OpenAI's ChatGPT models. With Zchat, you don't need to scour the web for Linux commands and code snippets. Simply type in comprehensive language queries and let the system generate the results for you. Zchat's AI capabilities provide precise responses directly in your terminal, saving your time and effort. Additionally, Zchat's intuitive Git integration simplifies your version control processes – bidding farewell to cheat sheets and notes. With Zchat, complete tasks quickly and conveniently.

<br>

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/d39a5df5-3864-4314-b4c6-9bb944233634" draggable="false" ondragstart="return false; "alt="ChatGPt conbined with the Terminal" title="ChatGPt conbined with the Terminal" width="700px" />
  </picture>
</p>

<br>

## Create your OpenAI API Key

To utilise Zchat, you initially need to procure the API key. You can generate this key from your OpenAI account, which will subsequently be used for authentication. Here's how to get your API key:

1. Sign in to your [OpenAI account][open-ai-account].
2. Search for the "Create new secret key" option and select it.

This API key serves as your passport to access and engage with Zchat.

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/3ae7efce-01ad-4069-80bf-7a8dec2dc3b1" draggable="false" ondragstart="return false; "alt="IMG show how to create new secret key" title="Create new secret key" width="750px" />
  </picture>
</p>

Once you have obtained your [API Key][open-ai-API], integrating ChatGPT's services with Zchat is straightforward. Note that once you have copied the API Key and closed the pop-up window, you will no longer be able to access and view the key, making it essential that you store it in a secure and safe place.
<br><br>

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/8db385ed-d310-4fb0-a8a5-5dc3514ca357" draggable="false" ondragstart="return false; "alt="IMG show an example of a OpenAI API Key" title="OpenAI API Key" width="750px" />
  </picture>
</p>

<br>

## Getting Started

Here are the two methods you can choose from:

**Automatic Download via `curl`:** Simply execute the following command in your terminal to quickly download and seamlessly install the utility:

```shell
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/nicolodiamante/zchat/HEAD/bootstrap.zsh)"
```

**Manual Cloning:** For those who prefer a hands-on approach, you can manually clone the repository:

```shell
git clone https://github.com/nicolodiamante/zchat.git ~/zchat
```

<br>

### Post-Download Steps

**Directory Navigation & Script Execution:** Navigate to the root directory of the repository, and then execute the installation script using the following command:

```shell
source utils/install.zsh
```

**Zchat Configuration:** This script aims to locate the `zshrc` file, then appends the path `zchat/script` to the `fpath` variable, and sets the `OPENAI_API_KEY` variable.

```shell
# Zchat path.
fpath=(~/zchat/script $fpath)
autoload -Uz zchat
```

<br>

### Install via [Oh My Zsh][ohmyzsh]

```shell
git clone https://github.com/nicolodiamante/zchat.git $ZSH_CUSTOM/plugins/zchat
```

- Add to your zshrc plugins array `plugins=(... zchat)`
- Paste your API Key at the `OPENAI_API_KEY` variable in your zshrc.
- Restart the shell to activate.
  <br><br>

### Setting up dependencies

After completing the installation process, please open your zshrc file. Copy and paste your OpenAI API Key into the `OPENAI_API_KEY` variable slot. The script is programmed to use the GPT-4 models by default. However, it should be noted that access to GPT-4 API is limited only to APIs with proven successful payment history. If you have not met the qualifications for accessing GPT-4, we recommend opting for the GPT-3.5-Turbo model instead.

```shell
# Zchat dependencies.
export OPENAI_API_KEY=
export OPENAI_GPT_MODEL=gpt-4
```

> For Zchat to function properly, jq must be installed on your operating system. The script will automatically check for this software. If it isn't detected, the script will proceed with the necessary installation.

<br>

## How to use Zchat

```shell
zch <description of task>
```

### Completion

1. To initiate the completion, simply type 'zch' followed by the command that you want to use for your query.
2. After formulating your query in natural language, press the 'Enter' key to execute it.

<br><br>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/nicolodiamante/zchat/assets/48920263/0a2f6192-5000-4b35-a063-dd7952b22084" draggable="false" ondragstart="return false;" alt="Zchat Completion" title="Zchat Completion" />
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/7d4091d1-fec2-4cd9-ba9b-36ed2f207e1a" draggable="false" ondragstart="return false; "alt="Zchat Completion" title="Zchat Completion" width="650px" />
  </picture>
</p>

<br><br>

## Notes

Upon launching Zchat, the script automatically checks whether you're in a Git repository. If it determines that you are, Zchat will present relevant Git commands and provide guidance. If you're not in a Git repository, Zchat assists you in accessing the appropriate command line tools to find the most effective solution for your task.

### Resources

#### OpenAI

- [OpenAI Documentation][intro]
- [OpenAI Models][open-ai-models]
- [OpenAI Chat][chat-completions]

#### Zsh Documentations

- [Documentation Index][zsh-docs]
- [User Guide][zsh-docs-guide]

### Contribution

Thank you for considering using Zchat. Any suggestions or feedback you may have for improvement are welcome. If you encounter any issues or bugs, please report them on the [issues page][issues].
<br><br>

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/977f7ef6-11c9-495f-8b66-1b0c762d95c6" draggable="false" ondragstart="return false;" /></>
  </picture>
</p>

<p align="center">
  <a href="https://nicolodiamante.com" target="_blank">
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/a2d53e2d-ed83-483d-b27a-4c1f04c15061" draggable="false" ondragstart="return false;" alt="Nicol&#242; Diamante Portfolio" title="Nicol&#242; Diamante" width="17px" />
  </a>
</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/nicolodiamante/zchat/assets/48920263/cb5d36f0-ccad-4fee-9dd4-e2f895ab225c" draggable="false" ondragstart="return false;" alt="MIT License" title="MIT License" />
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/b9e78453-f608-42fa-8440-9ed0118bb354" draggable="false" ondragstart="return false; "alt="MIT License" title="MIT License" width="95px" />
  </picture>
</p>

<!-- Link labels: -->

[open-ai-account]: https://chat.openai.com/auth/login
[open-ai-API]: https://beta.openai.com/account/api-keys
[open-ai-models]: https://platform.openai.com/docs/models
[intro]: https://platform.openai.com/docs/introduction
[chat-completions]: https://platform.openai.com/docs/guides/chat
[ohmyzsh]: https://github.com/robbyrussell/oh-my-zsh/
[zsh-docs]: http://zsh.sourceforge.net/Doc
[zsh-docs-guide]: http://zsh.sourceforge.net/Guide/zshguide.html
[issues]: https://github.com/nicolodiamante/zchat/issues
