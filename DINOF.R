# Function to interpolate missing values of a sparse matrix
# based on Beckers and Rixen (2003), 

dineof <- function(Xo, n.max=NULL, ref.pos=NULL, delta.rms=1e-5){
  
  library(irlba)
  
  if(is.null(n.max)){
    n.max=dim(Xo)[2]
  } 
  
  na.true <- which(is.na(Xo))
  na.false <- which(!is.na(Xo))
  if(is.null(ref.pos)) ref.pos <- sample(na.false, max(30, 0.01*length(na.false)))
  
  Xa <- replace(Xo, c(ref.pos, na.true), 0)
  rms.prev <- Inf
  rms.now <- sqrt(mean((Xa[ref.pos] - Xo[ref.pos])^2))
  n.eof <- 1
  RMS <- rms.now
  NEOF <- n.eof
  Xa.best <- Xa
  n.eof.best <- n.eof 
  while(rms.prev - rms.now > delta.rms & n.max > n.eof){ #loop for increasing number of eofs
    while(rms.prev - rms.now > delta.rms){ #loop for replacement
      rms.prev <- rms.now
      SVDi <- irlba(Xa, nu=n.eof, nv=n.eof) 
      RECi <- as.matrix(SVDi$u[,seq(n.eof)]) %*% as.matrix(diag(SVDi$d[seq(n.eof)], n.eof, n.eof)) %*% t(as.matrix(SVDi$v[,seq(n.eof)]))
      Xa[c(ref.pos, na.true)] <- RECi[c(ref.pos, na.true)]
      rms.now <- sqrt(mean((Xa[ref.pos] - Xo[ref.pos])^2))
      print(paste(n.eof, "EOF", "; RMS =", round(rms.now, 8)))
      RMS <- c(RMS, rms.now)
      NEOF <- c(NEOF, n.eof)
      gc()
      if(rms.now == min(RMS)) {
        Xa.best <- Xa
        n.eof.best <- n.eof
      }
    }
    n.eof <- n.eof + 1
    rms.prev <- rms.now
    SVDi <- irlba(Xa, nu=n.eof, nv=n.eof) 
    RECi <- as.matrix(SVDi$u[,seq(n.eof)]) %*% as.matrix(diag(SVDi$d[seq(n.eof)], n.eof, n.eof)) %*% t(as.matrix(SVDi$v[,seq(n.eof)]))
    Xa[c(ref.pos, na.true)] <- RECi[c(ref.pos, na.true)]
    rms.now <- sqrt(mean((Xa[ref.pos] - Xo[ref.pos])^2))
    print(paste(n.eof, "EOF", "; RMS =", round(rms.now, 8)))
    RMS <- c(RMS, rms.now)
    NEOF <- c(NEOF, n.eof)
    gc()
    if(rms.now == min(RMS)) {
      Xa.best <- Xa
      n.eof.best <- n.eof
    }
  }
  
  Xa <- Xa.best
  n.eof <- n.eof.best
  rm(list=c("Xa.best", "n.eof.best", "SVDi", "RECi"))
  
  Xa[ref.pos] <- Xo[ref.pos]
  
  RESULT <- list(
    Xa=Xa, n.eof=n.eof, RMS=RMS, NEOF=NEOF
  )
  
  RESULT
}