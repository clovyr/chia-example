# About Clovyr Code

Clovyr Code is VSCode in your browser. It connects and communicates directly with your git host, without sharing any credentials or information with anyone else, including Clovyr. The current beta (that's what you're using right now!) creates ephemeral, private VPS instances on wNext (hosting by Clovyr) with no sign-up required. We'll be releasing the ability to target any cloud or on-prem instance soon. 

Get that cozy feeling of developing locally on a machine you control, with the freedom to never worry about setting up project-specific environments again. Welcome!

Some important things to know:
   - You do not need to register an account with Clovyr to use Clovyr Code. 
   - Deleting your browser cookies will **permanently** unlink your browser from your Clovyr Code instance. (We'll be releasing the ability to create a Clovyr account to restore this link and also link multiple devices in the future.)
   - Your existing Clovyr Code environments can be relaunched and/or deleted via the Challenge splash page [clovyr.app/instant/code-chia](https://clovyr.app/instant/code-chia) or [clovyr.app/code](https://clovyr.app/code).
   - Fresh Chialisp environments can be launched via [clovyr.app/instant/code-chia](https://clovyr.app/instant/code-chia)
   - Clovyr Code is in beta. Please report any feedback or issues to support@clovyr.io - or, during the Chia Developer Challenge, via the Clovyr Code channel in Chia's keybase group

## Working in your own repo

1. Navigate to your git host (we'll use GitHub as an example here) and create a repo. It can be public or private. 
2. Copy the git URL of the repo (click the "Code" button dropdown on the repo). The format will be "https://github.com/user/my-challenge.git"
3. Switch back to Clovyr Code
4. Navigate to the parent directory of the chia-example repo (`cd /home/clovyr/git/`)
   - This is a good time to check that your browser security settings allow you to paste in the terminal. (`CTRL+V` or `CTRL+SHIFT+V`)
   - If not, look for a popup requesting access to your clipboard, or a clipboard icon in the URL bar
5. `git clone [your git url]`
6. If the directory is private, you'll be asked to enter your GitHub username & password now. Skip to step 8. 
7. If the directory is public, you can continue as normal (create a branch and begin working).
   - When you make your first commit, you'll be prompted to enter your Name and Email Address that will be associated with the commit log. 
8. When you make your first push, you'll be prompted to enter your GitHub Account email and password. 
   - Don't enter your plaintext GitHub password!
   - Go to github.com/settings/tokens and click "Generate a new token".
   - Under "Select scopes," check the boxes for (at a minimum): "Repos"
   - Copy/paste the generated token into the Clovyr Code terminal for "Password". (it will not be shown)
   - Hit enter to submit. 
   - You can now perform all in scope actions (like `git push`) via the Clovyr Code command line.
9. After merging changes into main your own repo, remember to `git pull` on your main branch so they show up in Clovyr Code! 

## Tips & Tricks

   - To view a markdown page like this one in the VSCode Preview Pane (pretty mode), press `CTRL+SHIFT+V`
   - To paste in the terminal, use `CTRL+SHIFT+V`
   - If paste in the terminal does not work, look for a browser popup requesting clipboard access and click "Allow"
   - If git commands are not working, make sure that you are in the working directory of the repo (not just ~/git)
   - To open or close the terminal, use `` CTRL+` ``
   - The Clovyr Code environment is customizable. Run any commands (eg `git clone` or `pip install`) just as you would on a local machine

   

   
