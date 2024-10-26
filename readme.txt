The Exit() states and Enter() states of the player FSM seem to be the best time
to emit a signal in order to increment the score...

Will have the problem of Ralph will get a score of 1 when he hasn't made a
successful crossing of the screen yet.

Could handle with logic of starting at -1 and only displaying the score once it
hits zero (i.e., the label is hide() until we want it to be visible).

I'm definitely going to struggle to connect a custom signal between the two. I
will want to go slow and watch a couple tutorials to get this right.

I want to connect them properly where the pedestal can have a script isolated on
it's own that works and doesn't need a direct reference to the player or it
errors out if it's not in the main scene, etc.
