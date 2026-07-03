# cycle 10 / T3: 自由エネルギー=log Mahler 測度=エントロピー と Lehmer 問題の接続(小計算)。
# Mahler 測度 m(P)=|lc|·Π max(1,|root|)。log m = エントロピー(ℝ側, 非決定可能一般)。
R.<x>=ZZ[]
def mahler(P):
    C=P.change_ring(CC); lc=abs(C.leading_coefficient())
    m=RR(lc)
    for r,mult in C.roots():
        m*= max(1,abs(r))^mult
    return m
lehmer = x^10+x^9-x^7-x^6-x^5-x^4-x^3+x+1
examples = {
  "Lehmer(x^10+...)": lehmer,
  "x^2-x-1 (黄金/Fib)": x^2-x-1,
  "x^2-3x+1 (cycle8 T3)": x^2-3*x+1,
  "x^3-x-1 (plastic)": x^3-x-1,
  "x-2 (cycle7, a_L=2^L-1)": x-2,
  "cyclotomic x^2+x+1": x^2+x+1,
}
print("="*70); print("Mahler 測度 = exp(自由エネルギー/エントロピー); Lehmer 数と比較"); print("="*70)
for name,P in examples.items():
    m=mahler(P)
    print(f"  {name:28}: m={float(m):.6f}, log m(=エントロピー)={float(log(m)):.6f}")
print(f"\n  Lehmer 数 ≈ 1.176280818 (m(P)>1 の既知最小, Lehmer 予想=これが下限)")
print(f"  比較: 全域木 4G/π=1.16624 は log-エントロピー(2変数, Boyd-Lawton で下限なし側)")
