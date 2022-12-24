# LCP-method
Local Coherence Pattern is a novel image descriptor for fingerprint liveness detection using the local coherence of a given image. Based on the observation that materials employed for making fake fingerprints (e.g., silicone, wood glue, etc.) tend to yield the nonuniformity in the captured image due to the replica fabrication process, we focus on the difference of the dispersion in the image gradient field between live and fake fingerprints. More specifically, we propose to define the local patterns of the coherence along the dominant direction, the so-called local coherence patterns, as our features, which are fed into the linear support vector machine (SVM) classifier to determine whether a given fingerprint is fake or not.


W. Kim, "Fingerprint Liveness Detection Using Local Coherence Patterns," in IEEE Signal Processing Letters, vol. 24, no. 1, pp. 51-55, Jan. 2017, doi: 10.1109/LSP.2016.2636158.

fscore file : calculates Accuracy, Sensitivity, Specificity, Precision, Recall, F-Measure, G-mean of the model

Other files contain noisy model.
