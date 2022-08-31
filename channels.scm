(list (channel
        (name 'my-guix-packages)
        (url "https://gitlab.com/methuselah-0/my-guix-packages.git")
        (branch "master")
        (commit
          "c823da9498008c6e91976f7077a3588653d673dc"))
      (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch #f)
        (commit
          "236746900f062b34c857c4aab21709bcf1448ac7")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
