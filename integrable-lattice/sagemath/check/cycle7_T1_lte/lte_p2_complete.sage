# cycle 8 / T1: LTE を p=2 も含め完全に検証(命題化のため)。
# p 奇, p∤c: v_p(c^L-1) = 0 (ord∤L) / v_p(c^ord-1)+v_p(L) (ord|L)。
# p=2, c 奇: v_2(c^L-1) = v_2(c-1) (L 奇) / v_2(c-1)+v_2(c+1)+v_2(L)-1 (L 偶)。

def v2_LTE(c,L):
    if c%2==0: return None
    if L%2==1: return ZZ(c-1).valuation(2)
    return ZZ(c-1).valuation(2)+ZZ(c+1).valuation(2)+ZZ(L).valuation(2)-1

print("="*70)
print("p=2 LTE 検証: v_2(c^L-1)")
print("="*70)
allok=True
for c in [3,5,7,9,15]:
    ok=all( (c^L-1).valuation(2)==v2_LTE(c,L) for L in range(1,30) )
    allok=allok and ok
    print(f"  c={c}: v_2(c^L-1)=LTE 予測 (L=1..29): {ok}; v_2 列 L=1..10: {[(c^L-1).valuation(2) for L in range(1,11)]}")
print(f"\n p=2 LTE 全 c で一致: {allok}")
print("="*70)
