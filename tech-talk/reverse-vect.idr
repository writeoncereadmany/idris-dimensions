reverse' : List a -> List a -> List a
reverse' [] acc = acc
reverse' (x :: xs) acc = reverse' xs (x :: acc)

reverse : List a -> List a
reverse xs = reverse' xs []
