const numberParts = /\d+/g;

export function naturalCompare(a: string, b: string): number {
    const aMatches = a.matchAll(numberParts);
    const bMatches = b.matchAll(numberParts);
    let aLastIndex = 0;
    let aPeek = aMatches.next();
    let bLastIndex = 0;
    let bPeek = bMatches.next();
    while (!aPeek.done && !bPeek.done) {
        const nonNumeric = a.slice(aLastIndex, aPeek.value.index).localeCompare(b.slice(bLastIndex, bPeek.value.index));
        if (nonNumeric !== 0) return nonNumeric;
        const numeric = Number(aPeek.value) - Number(bPeek.value);
        if (numeric !== 0) return numeric;
        aLastIndex = aPeek.value.index + aPeek.value.length;
        bLastIndex = bPeek.value.index + bPeek.value.length;
        aPeek = aMatches.next();
        bPeek = bMatches.next();
    }
    return a.slice(aLastIndex).localeCompare(b.slice(bLastIndex));
}
