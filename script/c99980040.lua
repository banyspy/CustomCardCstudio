--HN CPU Candidate Nepgear
--Scripted by Raviost
function c99980040.initial_effect(c)
  --(1) Special Summon from hand
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_SPSUMMON_PROC)
  e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
  e1:SetRange(LOCATION_HAND)
  e1:SetCountLimit(1,99980040)
  e1:SetCondition(c99980040.sphcon)
  c:RegisterEffect(e1)
  --(2) Search
  local e2=Effect.CreateEffect(c)
  e2:SetDescription(aux.Stringid(99980040,0))
  e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
  e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e2:SetProperty(EFFECT_FLAG_DELAY)
  e2:SetCode(EVENT_TO_GRAVE)
  e2:SetCountLimit(1,99980041)
  e2:SetCondition(c99980040.thcon)
  e2:SetTarget(c99980040.thtg)
  e2:SetOperation(c99980040.thop)
  c:RegisterEffect(e2)
  --(3) Increase lvl
  local e3=Effect.CreateEffect(c)
  e3:SetDescription(aux.Stringid(99980040,1))
  e3:SetCategory(CATEGORY_LVCHANGE)
  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e3:SetProperty(EFFECT_FLAG_DELAY)
  e3:SetCode(EVENT_SPSUMMON_SUCCESS)
  e3:SetCondition(c99980040.lvlcon)
  e3:SetTarget(c99980040.lvltg)
  e3:SetOperation(c99980040.lvlop)
  c:RegisterEffect(e3)
end
c99980040.listed_names={99980040}
--(1) Special Summon from hand
function c99980040.sphfilter(c)
  return c:IsFaceup() and c:IsSetCard(0x1998) and not c:IsCode(99980040)
end
function c99980040.sphcon(e,c)
  if c==nil then return true end
  return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
  and Duel.IsExistingMatchingCard(c99980040.sphfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
--(2) Search
function c99980040.thcon(e,tp,eg,ep,ev,re,r,rp)
  return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c99980040.thfilter1(c,tp)
  return c:IsSetCard(0x998) and c:IsType(TYPE_MONSTER) and not c:IsPublic()
  and Duel.IsExistingMatchingCard(c99980040.thfilter2,tp,LOCATION_DECK,0,1,nil,c:GetLevel())
end
function c99980040.thfilter2(c,lv)
  return c:IsSetCard(0x998) and c:IsType(TYPE_MONSTER) and c:GetLevel()==lv and c:IsAbleToHand()
end
function c99980040.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c99980040.thfilter1,tp,LOCATION_HAND,0,1,nil,tp) end
  Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
  Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c99980040.thop(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
  local g1=Duel.SelectMatchingCard(tp,c99980040.thfilter1,tp,LOCATION_HAND,0,1,1,nil,tp)
  if g1:GetCount()==0 then return end
  Duel.ConfirmCards(1-tp,g1)
  Duel.ShuffleHand(tp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
  local g2=Duel.SelectMatchingCard(tp,c99980040.thfilter2,tp,LOCATION_DECK,0,1,1,nil,g1:GetFirst():GetLevel())
  Duel.SendtoHand(g2,nil,REASON_EFFECT)
  Duel.ConfirmCards(1-tp,g2)
end
--(3) Increase lvl
function c99980040.lvlcon(e,tp,eg,ep,ev,re,r,rp)
  return re and re:GetHandler():IsSetCard(0x998)
end
function c99980040.lvltg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c99980040.lvlop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if c:IsRelateToEffect(e) and c:IsFaceup() then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_LEVEL)
    e1:SetReset(RESET_EVENT+0x1ff0000)
    e1:SetValue(1)
    c:RegisterEffect(e1)
  end
end