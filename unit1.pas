unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  InsertionNumbers = record
    randomInsertionAsc:integer;
    randomInsertionDesc:integer;
    sortedInsertion:integer;
end;

//random number generator
procedure RandomiseInsertion(var insertionArray:array of insertionNumbers);
var loop:integer;
begin

randomize;
          for loop:= 1 to 10000 do
          begin
            insertionArray[loop].randomInsertionAsc:=random(10000)+1;
            insertionArray[loop].randomInsertionDesc:=random(10000)+1;
          end;
end;

//insertion sort ascending
Procedure InsertionSortAsc(var insertionArray:array of insertionNumbers; var timeBeforeAsc,timeAfterAsc:TDateTime);
Var outer, inner, temp:Integer;

Begin
timeBeforeAsc:=now;
 For outer := 1 to 10000 do
  Begin
   temp := insertionArray[outer].randomInsertionAsc;
   inner := outer;
   While ((inner > 1) AND (insertionArray[inner-1].randomInsertionAsc > temp)) do
    Begin
     insertionArray[inner].randomInsertionAsc := insertionArray[inner-1].randomInsertionAsc;
     inner := inner - 1;
    End;
   insertionArray[inner].randomInsertionAsc := temp;
  End;
 timeAfterAsc:=now;
end;

//insertion sort descending
Procedure InsertionSortDesc(var insertionArray:array of insertionNumbers; var timeBeforeDesc,timeAfterDesc:TDateTime);
Var outer, inner, temp:Integer;

Begin
timeBeforeDesc:=now;
 For outer := 1 to 10000 do
  Begin
   temp := insertionArray[outer].randomInsertionDesc;
   inner := outer;
   While ((inner > 1) AND (insertionArray[inner-1].randomInsertionDesc < temp)) do
    Begin
     insertionArray[inner].randomInsertionDesc := insertionArray[inner-1].randomInsertionDesc;
     inner := inner - 1;
    End;
   insertionArray[inner].randomInsertionDesc := temp;
  End;
timeAfterDesc:=now;
end;

//write to file
procedure Write(var insertionArray:array of insertionNumbers; timeBeforeAsc,timeAfterAsc,timeBeforeDesc,timeAfterDesc:TDateTime);
var resultsAscFile,resultsDescFile:textfile;
loop:integer;
begin
assignFile(resultsAscFile, 'resultAsc.txt');
assignFile(resultsDescFile, 'resultDesc.txt');
reWrite(resultsAscFile);
reWrite(resultsDescFile);

for loop:= 1to 10000 do
    begin
         writeLn(resultsAscFile, intToStr(insertionArray[loop].randomInsertionAsc));
         writeLn(resultsDescFile, intToStr(insertionArray[loop].randomInsertionDesc));
    end;
         writeLn(resultsAscFile, TimeToStr(timeBeforeAsc) + ' ' + TimeToStr(timeAfterAsc));
         writeLn(resultsDescFile, TimeToStr(timeBeforeDesc) + ' ' + TimeToStr(timeAfterDesc));


closeFile(resultsAscFile);
closeFile(resultsDescFile);


end;

// insertion sort program
procedure TForm1.Button1Click(Sender: TObject);
var insertionArray:array[1..10000] of insertionNumbers;
timeBeforeAsc,timeAfterAsc,timeBeforeDesc,timeAfterDesc: TDateTime;
begin
     RandomiseInsertion(insertionArray);
     InsertionSortAsc(insertionArray,timeBeforeAsc,timeAfterAsc);
     InsertionSortDesc(insertionArray,timeBeforeDesc,timeAfterDesc);
     Write(insertionArray,timeBeforeAsc,timeAfterAsc,timeBeforeDesc,timeAfterDesc);
end;
end.

