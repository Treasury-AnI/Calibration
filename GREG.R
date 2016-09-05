
GREGClean <- function(W,C,B,L,U){
  Diff = Inf
  Int = B - C%*%t(W)
  while (sum((Int*Int)/B) < Diff){
    Tot = t(Int)
    Diff = sum(Tot*Tot/t(B))
    Mid = (C*t(replicate(nrow(C),c(W))))%*%t(C)
    #W = pmax(pmin(W*(1+(Tot%*%solve(Mid))%*%C), U), L)
    W = W*(1+(t(solve(Mid, t(Tot))))%*%C)
    Int = B - C%*%t(W)
    W[W > U] <- U
    W[W < L] <- L
  }
  return(W)
}

# Test script, answer is c(2, 2, 4, 3) to numerical precision.
Start <- rbind(c(2, 3, 4, 8))
Char <- rbind(c(3, 4, 0, 2), 
              c(5, 3, 7, 2))
Ben <- rbind(20, 50)
Lower <- 2
Upper <- 20

library(microbenchmark)

# Some overhead with vectorising small examples...
OUT <- microbenchmark(
  GREGClean(Start, Char, Ben, Lower, Upper)
)