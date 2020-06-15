# Flowfield Image
Built with processing, this code generates an animation of an image disintegrating in the wind. This is done by identifying bright pixels that we want to keep, effectively deleting black backgrounds, turning those pixels into objects with position and velocity data, and the applying the acceleration on it from a flowfield that was generated using Perlin Noise. This slowly starts to move pixels around in a natural manner.

![Example Image](https://github.com/avelaga/flowfield-image/blob/master/example.gif)
