<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/nicolodiamante/zchat/assets/48920263/2eae1d23-a5b0-484c-ba57-ea30a821545d" draggable="false" ondragstart="return false;" alt="Zchat" title="Zchat" />
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/42de772d-6457-47bd-b5b7-fc5b624e56ef" draggable="false" ondragstart="return false; "alt="Zchat" title="Zchat" />
  </picture>
</p>

Maximise your productivity and streamline your terminal experience with Zchat (zch) - a command-line productivity tool powered by OpenAI's [ChatGPT][chatgpt] models. Quickly generate Linux commands and code snippets from natural language queries without the need to manually search the web. Leverage AI capabilities to get accurate answers directly in your terminal in a time and effort-efficient manner. Furthermore, Zchat's Git integration makes working with version control even simpler - goodbye cheat sheets and notes. Get the job done quickly and easily.

<br>

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/d39a5df5-3864-4314-b4c6-9bb944233634" draggable="false" ondragstart="return false; "alt="ChatGPt conbined with the Terminal" title="ChatGPt conbined with the Terminal" width="700px" />
  </picture>
</p>

<br>

## Create your OpenAI API Key

To use Zchat, you'll first need to obtain the API key. This can be done by generating a new secret key from your OpenAI account, which will be required for authentication. To get started, you can obtain the key by following these steps. First, log in to your [OpenAI account][open-ai-account]. Next, look for the "Create new secret key" option and click on it.

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/3ae7efce-01ad-4069-80bf-7a8dec2dc3b1" draggable="false" ondragstart="return false; "alt="IMG show how to create new secret key" title="Create new secret key" width="750px" />
  </picture>
</p>

Once you have obtained your [API Key][open-ai-API], integrating ChatGPT's services with Zchat is straightforward. Note that once you have copied the API Key and closed the pop-up window, you will no longer be able to access and view the key, making it essential that you store it in a secure and safe place.
<br><br>

<p align="center">
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/270af1e8-7d23-4c6a-9c1c-404908b2d1cc" draggable="false" ondragstart="return false; "alt="IMG show an example of a OpenAI API Key" title="OpenAI API Key" width="750px" />
  </picture>
</p>

<br>

## Getting Started

Download the repository via curl:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nicolodiamante/zchat/HEAD/bootstrap.sh)"
```

Alternatively, clone manually:

```shell
git clone https://github.com/nicolodiamante/zchat.git ~/zchat
```

Head over into the directory and then:

```shell
cd utils && source install.sh
```

The script will search for the file zshrc, then append the file path `zchat/script` to the variable fpath and set the `OPENAI_API_KEY` variable.

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

Once the installation is complete, open your zshrc file. Paste your OpenAI API Key to the `OPENAI_API_KEY` variable. By default, the script uses the GPT-3.5-turbo model. For most basic tasks, there is not much difference between GPT-4 and GPT-3.5 models. To use the latest GPT-4 model, just change the current model to `gpt-4`.

```shell
# Zchat dependencies.
export OPENAI_API_KEY=""
export OPENAI_GPT_MODEL="gpt-3.5-turbo"
```

> If you are not enrolled in the limited beta program for GPT-4, you will need to join a waiting list to use its API. Since developers have been given priority, it is unclear when non-developers will be granted access. Until that time, users should select the GPT-3.5-Turbo model as an alternative.

<br>

## How to use Zchat

```shell
zch <description of task>
```

### Completion

- Type `zch` to initiate the completion follow by the command that will be used as a basis for your query.
- Once you have written a natural language version of what you intend to do, press "enter" to execute it.

<br><br>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/nicolodiamante/zchat/assets/48920263/ff9078f7-22a3-4dcd-b76a-a2df31b20f9b" draggable="false" ondragstart="return false;" alt="Zchat Completion" title="Zchat Completion" />
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/8e9effe9-a1dc-4237-a04e-9850a370716f" draggable="false" ondragstart="return false; "alt="Zchat Completion" title="Zchat Completion" width="560px" />
  </picture>
</p>

<br><br>

## Notes

When you launch Zchat, it will automatically check if you are in a Git repository. If you are, it will provide relevant Git commands and guidance. If not, Zchat will help you access the right command line tools and find the best solution to complete your task.

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
  <picture>
    <img src="https://github.com/nicolodiamante/zchat/assets/48920263/a2d53e2d-ed83-483d-b27a-4c1f04c15061" draggable="false" ondragstart="return false;" alt="Nicol&#242; Diamante" title="Nicol&#242; Diamante" width="17px" />
  </picture>
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
[chatgpt]: https://openai.com/blog/chatgpt
[open-ai-models]: https://platform.openai.com/docs/models
[intro]: https://platform.openai.com/docs/introduction
[chat-completions]: https://platform.openai.com/docs/guides/chat
[ohmyzsh]: https://github.com/robbyrussell/oh-my-zsh/
[zsh-docs]: http://zsh.sourceforge.net/Doc
[zsh-docs-guide]: http://zsh.sourceforge.net/Guide/zshguide.html
[issues]: https://github.com/nicolodiamante/zchat/issues
