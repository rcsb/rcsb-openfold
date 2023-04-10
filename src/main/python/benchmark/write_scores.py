#!/usr/bin/python3
# Script to read an OpenFold output pickled file and write out (to a .scores file) some of the scores (e.g. pTM)

import pickle
import sys
import os
# Note that the pickled file contains numpy objects, so this implicitly requires numpy

if __name__ == "__main__":
    ser_of_outfile = sys.argv[1]
    # scores_file = sys.argv[2]
    basename = os.path.splitext(ser_of_outfile)[0]
    scores_file = basename + ".scores"

    with (open(ser_of_outfile, "rb")) as openfile:
        of_out = pickle.load(openfile)

    with (open(scores_file, "w")) as scoresfile:
        scoresfile.write("TM score: %f \n" % of_out["predicted_tm_score"])
        # paes = of_out["predicted_aligned_error"]
        # scoresfile.write("PAE: \n")
        # for i in range(0, paes.shape[0]):
        #     for j in range(0, paes.shape[1]):
        #         scoresfile.write(str(paes[i][j]) + " ")
        #     scoresfile.write("\n")
        # print(of_out["plddt"])
