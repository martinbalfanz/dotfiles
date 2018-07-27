{:user {:plugins [[lein-pprint "1.2.0"]
                  [lein-ancient "0.6.15"]
                  [lein-try "0.4.3"]
                  [nightlight/lein-nightlight "RELEASE"]]
        :dependencies [[slamhound "1.5.5"]
                       [com.bhauman/rebel-readline "0.1.4"]]
        :aliases {"rebl" ["trampoline" "run" "-m" "rebel-readline.main"]}}}
