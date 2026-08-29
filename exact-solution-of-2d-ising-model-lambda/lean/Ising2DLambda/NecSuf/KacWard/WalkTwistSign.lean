/-
必要十分版: 有限な辺列に沿うねじれ符号の積は、二つの切断線を横切る
回数の偶奇だけで決まる。

辺の接続、閉性、回転位相、体は使わない。必要なのは二つの Bool 値写像と、
符号写像が xor を積へ送ることだけである。
-/
import Mathlib.Data.List.Defs
import Mathlib.Data.Int.Basic

namespace Ising2DLambda.NecSuf.KacWard

def parity {E : Type} (cut : E → Bool) : List E → Bool
  | [] => false
  | e :: es => Bool.xor (cut e) (parity cut es)

def boolSign (p : Bool) : ℤ := if p then -1 else 1

def twistParity {E : Type} (a b : Bool) (horizontal vertical : E → Bool) (e : E) : Bool :=
  Bool.xor (a && horizontal e) (b && vertical e)

def twistSign {E : Type} (a b : Bool) (horizontal vertical : E → Bool) (e : E) : ℤ :=
  boolSign (twistParity a b horizontal vertical e)

lemma boolSign_xor (p q : Bool) :
    boolSign (Bool.xor p q) = boolSign p * boolSign q := by
  cases p <;> cases q <;> decide

lemma parity_twistParity {E : Type} (a b : Bool) (horizontal vertical : E → Bool)
    (walk : List E) :
    parity (twistParity a b horizontal vertical) walk =
      Bool.xor (a && parity horizontal walk) (b && parity vertical walk) := by
  induction walk with
  | nil => simp [parity]
  | cons e walk ih =>
      simp only [parity, twistParity, ih]
      cases a <;> cases b <;> cases horizontal e <;> cases vertical e <;>
        cases parity horizontal walk <;> cases parity vertical walk <;> decide

theorem walkTwistSign_product_necSuf {E : Type} (a b : Bool)
    (horizontal vertical : E → Bool) (walk : List E) :
    (walk.map (twistSign a b horizontal vertical)).prod =
      boolSign (Bool.xor (a && parity horizontal walk) (b && parity vertical walk)) := by
  rw [← parity_twistParity]
  induction walk with
  | nil => rfl
  | cons e walk ih =>
      simp only [List.map_cons, List.prod_cons, twistSign, parity]
      rw [boolSign_xor, ih]

end Ising2DLambda.NecSuf.KacWard
