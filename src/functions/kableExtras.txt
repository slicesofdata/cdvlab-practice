kbl_it <- function(
  x, 
  caption = "", 
  align = "r",
  html_font = "Calibri"
  ) {
       if(!require(kableExtra)) {install.packages("kableExtra", dep = T)}
       if(!require(magrittr)) {install.packages("magrittr", dep = T)}
  x %>%        
       kableExtra::kbl(caption = caption, align = align) %>%
       kableExtra::kable_classic(full_width = F, html_font = html_font)
}

kbl_it_table <- function(x, 
                         caption = "", 
                         freq = F, 
                         percent = F,
                         align = "r"
   #                      data_only = F,
    #                     table_only = F
                         ) {
  if(!require(kableExtra)) {install.packages("kableExtra", dep = T)}
  if(!require(magrittr)) {install.packages("magrittr", dep = T)}

  varname = gsub(".*\\$", "", deparse(substitute(x)))
  
  t = table(x)
  if (!freq) {  t = prop.table(t)  }
    
  t = as.data.frame(t); names(t)[1] = varname
  if (!freq) { 
    names(t)[2] = "Prob"; t[["Prob"]] = round(t[["Prob"]], 2)
  }
  
  if (percent) {
    t[["Prob"]] = round(t[["Prob"]], 2) * 100; names(t)[2] = "%"
  }
  
  ret.obj = list(data = t, 
              table = t %>% 
                kableExtra::kbl(caption = caption, align = align) %>%
                kableExtra::kable_classic(full_width = F, html_font = "Calibri"))

  #ret = ifelse(table_only == T, ret.obj[[2]],
  #      ifelse(data_only  == T, ret.obj[[1]], ret.obj))

  return(ret.obj)
}