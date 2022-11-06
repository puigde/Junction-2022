# Junction 2022

### What are we building?
We are building a data-driven platform that allows users to:
 * Express and track their mental status
 * Anonymously connect and empathize with other users based on likelihood of improvement through a chat channel.

### Solution contents:
 * Flutter working demo app with the basic features of our platform.
 * Matchmaking model based on a large pretrained embedding transformer mapping documents to latent space representations gathering similarities and user profile extracted features. The model is re-trained through a metric lerning approach based on a custom adaptation of a contrastive loss which considers user feedback and status tracking data.
 * Chat assistant modeled as an agent in a chat enironment where conversation score-based rewards and penalizations are extracted to apply reinforcement learning.
 * Sample Dataset containing a definition and some rows of a lightweight pseudo-datawharehouse.


### Key aspect, automated improvement of the solution based on the usage gathered data unlocking:
 * Re-training our matching model based on user feedback and improvement results
 * Conversation data defining an environment for a virtual chat assistant dealing with ice-breakers, destructive conversations,etc. aiming to maximize connection quality.

The more usage the app has the better performance the AI could bring.
