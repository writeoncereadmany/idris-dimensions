data LinkedList : Type -> Type where
  Nil : LinkedList a
  (::) : a -> LinkedList a -> LinkedList a

addAll : LinkedList a -> LinkedList a -> LinkedList a
addAll [] ys = ys
addAll (x :: xs) ys = x :: (addAll xs ys)
