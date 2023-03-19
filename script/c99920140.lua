--Overlord Death Determination War
--Scripted by Raivost
function c99920140.initial_effect(c)
  --(1) Destroy
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(99920140,0))
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCountLimit(1,99920140+EFFECT_COUNT_CODE_OATH)
  e1:SetTarget(c99920140.destg)
  e1:SetOperation(c99920140.desop)
  c:RegisterEffect(e1)
end
--(1) Destroy
function c99920140.desfilter1(c,tp)
  local lg=c:GetColumnGroup(1,1)
  local atk=c:GetAttack()
  return c:IsFaceup() and c:IsSetCard(0xA92) and Duel.IsExistingMatchingCard(c99920140.desfilter2,tp,0,LOCATION_ONFIELD,1,nil,lg,atk)
end
function c99920140.desfilter2(c,g,atk)
  local seq=c:GetSequence() 
  return c:IsFaceup() and g:IsContains(c) and seq<5 and c:IsAttackBelow(atk)
end
function c99920140.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chk==0 then return Duel.IsExistingTarget(c99920140.desfilter1,tp,LOCATION_MZONE,0,1,nil,tp) end
  Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  Duel.SelectTarget(tp,c99920140.desfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c99920140.desop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc1=Duel.GetFirstTarget()
  local lg=tc1:GetColumnGroup(1,1)
  local atk=tc1:GetAttack()
  local g=Duel.GetMatchingGroup(c99920140.desfilter2,tp,0,LOCATION_MZONE,nil,lg,atk)
  if g:GetCount()==0 then return end
  Duel.Destroy(g,REASON_EFFECT)
  if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(99920140,1)) then
    Duel.BreakEffect()
    local def=tc1:GetDefense()
    local lv=tc1:GetLevel()
    local race=tc1:GetRace()
    local att=tc1:GetAttribute()
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not tc1:IsRelateToEffect(e) or tc1:IsFacedown()
    or not Duel.IsPlayerCanSpecialSummonMonster(tp,99920145,0,0x4011,atk,def,lv,race,att) then return end
    Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(99920140,2))
    local token=Duel.CreateToken(tp,99920145)
    tc1:CreateRelation(token,RESET_EVENT+0x1fe0000)
    Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_ATTACK_FINAL)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetLabelObject(tc1)
    e1:SetValue(c99920140.tokenatk)
    e1:SetReset(RESET_EVENT+0xfe0000)
    token:RegisterEffect(e1,true)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
    e2:SetValue(c99920140.tokendef)
    token:RegisterEffect(e2,true)
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_CHANGE_LEVEL)
    e3:SetLabelObject(tc1)
    e3:SetValue(c99920140.tokenlv)
    e3:SetReset(RESET_EVENT+0xfe0000)
    token:RegisterEffect(e3,true)
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_CHANGE_RACE)
    e4:SetLabelObject(tc1)
    e4:SetValue(c99920140.tokenrace)
    e4:SetReset(RESET_EVENT+0xfe0000)
    token:RegisterEffect(e4,true)
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
    e5:SetLabelObject(tc1)
    e5:SetValue(c99920140.tokenatt)
    e5:SetReset(RESET_EVENT+0xfe0000)
    token:RegisterEffect(e5,true)
    local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_SINGLE)
    e6:SetCode(EFFECT_SELF_DESTROY)
    e6:SetLabelObject(tc1)
    e6:SetCondition(c99920140.tokendes)
    e6:SetReset(RESET_EVENT+0xfe0000)
    token:RegisterEffect(e6,true)
    Duel.SpecialSummonComplete()
  end
end
function c99920140.tokenatk(e,c)
  local tc=e:GetLabelObject()
  return tc:GetAttack()
end
function c99920140.tokendef(e,c)
  local tc=e:GetLabelObject()
  return tc:GetDefense()
end
function c99920140.tokenlv(e,c)
  local tc=e:GetLabelObject()
  return tc:GetLevel()
end
function c99920140.tokenrace(e,c)
  local tc=e:GetLabelObject()
  return tc:GetRace()
end
function c99920140.tokenatt(e,c)
  local tc=e:GetLabelObject()
  return tc:GetAttribute()
end
function c99920140.tokendes(e)
  local tc=e:GetLabelObject()
  return not tc:IsRelateToCard(e:GetHandler())
end