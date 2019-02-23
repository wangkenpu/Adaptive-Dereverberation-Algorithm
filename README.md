# Adaptive-Dereverberation-Algorithm

MATLAB implemention of Weighted RLS based adaptive dereverberation algorithm.

## Layout
```
 ./
 +-- lib/
 |   +-- +util/                       utility functions
 |   |   |-- stftanalysis.m
 |   |   |-- stftsynthesis.m
 |   |-- demo_fdndlp.m
 |   |-- fdndlp.m
 |   |-- config.m
 +-- wav_sample/                      reverberant audio samples
 |   |-- sample_1ch.wav
 |   |-- sample_4ch.wav
 |   |-- sample_8ch.wav
 +-- wav_out                          dereverberant autio samples
 |   |--  drv_sample_1ch.wav
 |   |--  drv_sample_4ch.wav
 |   |--  drv_sample_8ch.wav
 |-- rls_ada.m                        Weighted RLS based adaptive dereverberation algorithm
 |-- config.m                         Configurations
 |-- demo_rls_ada.m                   Demo for WRLS-ADA
 |-- README.md
```

## Run the Demo

- Just run the script file `demo_rls_ada.m` and the audio sample in `wav_sample` will be used.
- To use your own data, change the `filepath` and `sample_name` in `demo_rls_ada.m`.
- The configrations are gathered in `config.m`. Be careful to change the settings.

## Reference

[WRLS-ADA](http://www.mirlab.org/conference_papers/international_conference/ICASSP%202009/pdfs/0003733.pdf)
Yoshioka T, Tachibana H, Nakatani T, et al. Adaptive dereverberation of speech signals with speaker-position change detection[C]. 2009 IEEE International Conference on Acoustics, Speech and Signal Processing. IEEE, 2009: 3733-3736.
