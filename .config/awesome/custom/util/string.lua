local stringutil = {}

stringutil.trim = function(input)
    return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end

return stringutil
