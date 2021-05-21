{ pkgs ? import <nixpkgs> {}
}:

    let
    
    includedPackages = with pkgs.rPackages; [
                tidyverse
                broom

                cowplot
                lemon

                MASS
                Matrix
                RSpectra

                bench

                ggbeeswarm # for the `bench` plots
                devtools
                knitr
                styler

                ];
    
    RstudioWithPackages =
        pkgs.rstudioWrapper.override{
            packages = includedPackages;
        };
        
    RWithPackages =
        pkgs.rWrapper.override{
            packages = includedPackages;
        };
    in

    pkgs.mkShell {
        buildInputs = with pkgs; [
            RstudioWithPackages 
            RWithPackages
            # libintl 
            # libiconv
            pandoc
            ];
        shellHook = ''
            mkdir -p "$(pwd)/_libs"
            export R_LIBS_USER="$(pwd)/_libs"
        '';
        }
