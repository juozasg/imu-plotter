void drawArrow(int sides, float r, float h)
{
  float angle = 360 / sides;
  float h2 = h + (h * 0.05); // arrow  height
  float r2 = r * 0.1; // sharp arrow tip circle radius

  // starting circle
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, 0 );
  }
  endShape(CLOSE);

  // cylinder body
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, h);
    vertex( x, y, 0);
  }
  endShape(CLOSE);

  // arrowhead starting circle
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r * 1.5;
    float y = sin( radians( i * angle ) ) * r * 1.5;
    vertex( x, y, h );
  }
  endShape(CLOSE);

  // arrow shape
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x1 = cos( radians( i * angle ) ) * r * 1.5;
    float y1 = sin( radians( i * angle ) ) * r * 1.5;
    float x2 = cos( radians( i * angle ) ) * r2;
    float y2 = sin( radians( i * angle ) ) * r2;
    vertex( x1, y1, h);
    vertex( x2, y2, h2);
  }
  endShape(CLOSE);

  // arrow tip
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r2;
    float y = sin( radians( i * angle ) ) * r2;
    vertex( x, y, h2 );
  }
  endShape(CLOSE);

 }