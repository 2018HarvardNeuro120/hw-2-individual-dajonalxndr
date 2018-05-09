clear all

load mixedIMG.mat

% plot the mixed images
plotImgs(imMix)

% whiten the images
new_imgs = whiten(imMix);

% plot new whitened images
plotImgs(new_imgs)

% learn weights
img_wghts = learnWeights(new_imgs);

% apply transformation
trans_imgs = new_imgs * img_wghts;

% plot images with applied transformation
plotImgs(trans_imgs)

